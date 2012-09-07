From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/2] virtio-ring: Allocate indirect buffers from cache
	when possible
Date: Fri, 7 Sep 2012 03:06:23 +0300
Message-ID: <20120907000623.GA3000@redhat.com>
References: <503CC904.3050207@gmail.com> <20120829110748.GB5970@redhat.com>
	<503E2F27.5060904@gmail.com> <20120829153833.GE7407@redhat.com>
	<503E4873.6060607@gmail.com> <871uigj747.fsf@rustcorp.com.au>
	<20120906050257.GA17656@redhat.com>
	<877gs7inx8.fsf@rustcorp.com.au>
	<20120906084526.GE17656@redhat.com>
	<87txvahfv3.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87txvahfv3.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, avi@redhat.com, Sasha Levin <levinsasha928@gmail.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 07, 2012 at 09:19:04AM +0930, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Thu, Sep 06, 2012 at 05:27:23PM +0930, Rusty Russell wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> > Yes without checksum net core always linearizes packets, so yes it is
> >> > screwed.
> >> > For -net, skb always allocates space for 17 frags + linear part so
> >> > it seems sane to do same in virtio core, and allocate, for -net,
> >> > up to max_frags + 1 from cache.
> >> > We can adjust it: no _SG -> 2 otherwise 18.
> >> 
> >> But I thought it used individual buffers these days?
> >
> > Yes for receive, no for transmit. That's probably why
> > we should have the threshold per vq, not per device, BTW.
> 
> Can someone actually run with my histogram patch and see what the real
> numbers are?
> 
> I'm not convinced that the ideal 17-buffer case actually happens as much
> as we think.  And if it's not happening with this netperf test, we're
> testing the wrong thing.
> 
> Thanks,
> Rusty.

hope to play with it next week
