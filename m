From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv3 RFC] virtio-pci: flexible configuration layout
Date: Wed, 30 Nov 2011 09:18:06 +0200
Message-ID: <20111130071805.GC17781@redhat.com>
References: <20111122183621.GA5235@redhat.com> <87hb1v1scp.fsf@rustcorp.com.au>
	<20111123084640.GE22734@redhat.com>
	<87ty5uxso3.fsf@rustcorp.com.au>
	<20111124070728.GH29994@redhat.com>
	<87vcq5t69c.fsf@rustcorp.com.au>
	<20111128084009.GB20084@redhat.com>
	<87sjl6tsnm.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87sjl6tsnm.fsf@rustcorp.com.au>
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
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 30, 2011 at 09:58:45AM +1030, Rusty Russell wrote:
> > I think I see a way to do that in a relatively painless way.
> > Do you prefer seeing driver patches or spec? Or are you not interested
> > in reusing the same structure at all?
> 
> I think we should look at code at this point; my gut says we're going to
> be not-quite-similar-enough-to-be-useful.  At which point, a clean-slate
> approach is more appealing.  But the code will show, one way or another.
> 
> Thanks,
> Rusty.

Makes sense, absolutely. So I'll hack on it and post and we can
judge the result.

One small comment that I'm afraid was lost in the noise
is that we should not add any 64 bit fields in the common area,
because there's no generic iowrite64/ioread64.

-- 
MST
