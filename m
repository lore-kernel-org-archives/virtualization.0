From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC 2/5] vringfd base/offset
Date: Sun, 6 Apr 2008 12:54:32 +1000
Message-ID: <200804061254.33153.rusty__1690.17314115099$1207450610$gmane$org@rustcorp.com.au>
References: <200804052202.09157.rusty@rustcorp.com.au>
	<200804052204.28518.rusty@rustcorp.com.au>
	<47F77431.3030608@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47F77431.3030608@qumranet.com>
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
To: Avi Kivity <avi@qumranet.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 05 April 2008 22:44:33 Avi Kivity wrote:
> Rusty Russell wrote:
> > It turns out the lguest (and possibly kvm) want the addresses in the
> > ring buffer to only cover a certain part of memory, and be offset.
> >
> >  					<mailto:rusty@rustcorp.com.au>
> > +0xAE	00-01	linux/vring.h
>
> Another virtualization subsystem already uses this range.

Nasty.  Not listed in the ioctl list, and didn't find it with grep 8(.  I 
don't think I ever used 0xAD which was assigned to me, so I can change to 
that.

Thanks,
Rusty.
