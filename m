From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/3] virtio: indirect ring entries
	(VIRTIO_RING_F_INDIRECT_DESC)
Date: Tue, 12 May 2009 23:53:53 +0930
Message-ID: <200905122353.54424.rusty__42216.3721327253$1242138339$gmane$org@rustcorp.com.au>
References: <1229620222-22216-1-git-send-email-markmc@redhat.com>
	<200905041149.00724.rusty@rustcorp.com.au>
	<1242061838.25337.8.camel@blaa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1242061838.25337.8.camel@blaa>
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
To: Mark McLoughlin <markmc@redhat.com>
Cc: netdev@vger.kernel.org, Dor Laor <dor@redhat.com>, Avi Kivity <avi@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 12 May 2009 02:40:38 am Mark McLoughlin wrote:
> > Blocked from doing the simpler thing, we've decided to go with a layer
> > of indirection.  But the patch is simple and clean, so there's nothing
> > fundamental to object to.
>
> Still have one FIXME in the patch worth looking at - at what point
> should we use an indirect entry rather than consuming N entries?

OK, I've applied these as is.  I'm doing some virtio net benchmarking (under 
lguest); I'll see if I can get a reasonable figure.  I don't think there's an 
obvious right answer; it depends how many more packets are coming as well as 
how many descriptors each will use.

Thanks,
Rusty.
