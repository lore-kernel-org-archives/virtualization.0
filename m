From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_net: Check for room in the vq before adding buffer
Date: Thu, 27 Aug 2009 20:36:07 +0930
Message-ID: <200908272036.07850.rusty@rustcorp.com.au>
References: <1251278908-18601-1-git-send-email-amit.shah@redhat.com>
	<200908271917.21260.rusty@rustcorp.com.au>
	<20090827102906.GA10885@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090827102906.GA10885@amit-x200.redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 27 Aug 2009 07:59:06 pm Amit Shah wrote:
> On (Thu) Aug 27 2009 [19:17:20], Rusty Russell wrote:
> > On Wed, 26 Aug 2009 06:58:28 pm Amit Shah wrote:
> > > Saves us one cycle of alloc-add-free if the queue was full.
> > > 
> > > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> > 
> > Thanks, applied with one change:
> > 
> > > @@ -323,7 +323,7 @@ static bool try_fill_recv_maxbufs(struct virtnet_info *vi, gfp_t gfp)
> > >  			break;
> > >  		}
> > >  		vi->num++;
> > > -	}
> > > +	} while (err > 0);
> > 
> > This is better as "while (err >= num)".  The other one is right (we only need
> > 1 buffer), this one we need to be able to fit "num" entries.
> 
> I'm missing something though: the value of 'num' changes in the loop and
> the value of num when it will be compared will just have been used by
> add_buf. The next iteration of the loop will probably use a different
> value (-- from just reading the code, not going over the cases in which
> this function is called).

Here's the code:

		num = skb_to_sgvec(skb, sg+1, 0, skb->len) + 1;
		skb_queue_head(&vi->recv, skb);

		err = vi->rvq->vq_ops->add_buf(vi->rvq, sg, 0, num, skb);
		if (err < 0) {
			skb_unlink(skb, &vi->recv);
			trim_pages(vi, skb);
			kfree_skb(skb);
			break;
		}
		vi->num++;
	} while (err >= num);

Now, it turns out that we always allocate packets of the same size.

So the number of descriptors required by the next packet will be the same as
for this packet.

Clear?
Rusty.
