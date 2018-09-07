From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 04/11] tuntap: simplify error handling in
	tun_build_skb()
Date: Fri, 7 Sep 2018 10:17:35 -0400
Message-ID: <20180907101645-mutt-send-email-mst__48891.5400849239$1536329934$gmane$org@kernel.org>
References: <20180906040526.22518-1-jasowang@redhat.com>
	<20180906040526.22518-5-jasowang@redhat.com>
	<20180906130425-mutt-send-email-mst@kernel.org>
	<e1f17f51-5f99-df18-4185-6c6e4dfaba89@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <e1f17f51-5f99-df18-4185-6c6e4dfaba89@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 07, 2018 at 11:22:00AM +0800, Jason Wang wrote:
> > > @@ -1668,6 +1668,9 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
> > >   	if (copied != len)
> > >   		return ERR_PTR(-EFAULT);
> > > +	get_page(alloc_frag->page);
> > > +	alloc_frag->offset += buflen;
> > > +
> > This adds an atomic op on XDP_DROP which is a data path
> > operation for some workloads.
> 
> Yes, I have patch on top to amortize this, the idea is to have a very big
> refcount once after the frag was allocated and maintain a bias and decrease
> them all when allocating new frags.'

Why bother with refcounting for a drop though? It should be simple.

-- 
MST
