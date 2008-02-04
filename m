From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Patch] virtio_blk: implement naming for vda-vdz, vdaa-vdzz,
	vdaaa-vdzzz
Date: Mon, 4 Feb 2008 23:36:06 +1100
Message-ID: <200802042336.06287.rusty__5709.9585225389$1202128767$gmane$org@rustcorp.com.au>
References: <200801311553.53653.borntraeger__25311.9055800655$1201791369$gmane$org@de.ibm.com>
	<200802010833.51809.borntraeger@de.ibm.com>
	<200802010905.00336.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200802010905.00336.borntraeger@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 01 February 2008 19:05:00 Christian Borntraeger wrote:
> Am Freitag, 1. Februar 2008 schrieb Christian Borntraeger:
> > Right. I will fix that with an additional patch.
>
> This patch goes on top of the minor number patch. Please let me know if
> you want a merged patch:
>
> Currently virtio_blk creates the disk name combinging "vd"  with 'a'++.
> This will give strange names after vdz. I have implemented names up to
> vdzzz - inspired by the sd.c code. That should be sufficient for now.

Thanks, both applied.

Cheers,
Rusty.
PS.  Am on vacation now, for 4 weeks.  Will check mail only occasionally.
