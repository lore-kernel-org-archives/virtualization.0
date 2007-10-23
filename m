From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [git pull] lguest: paravirt boot code
Date: Tue, 23 Oct 2007 17:44:15 +1000
Message-ID: <200710231744.16296.rusty__31728.711402002$1193125609$gmane$org@rustcorp.com.au>
References: <200710221237.14542.rusty@rustcorp.com.au>
	<200710231603.21620.rusty@rustcorp.com.au>
	<200710230855.06253.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200710230855.06253.borntraeger@de.ibm.com>
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
Cc: lguest <lguest@ozlabs.org>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 23 October 2007 16:55:06 Christian Borntraeger wrote:
> Having virtio in Linus tree would make my life easier wiring it up for
> virtualization on s390.

Indeed.  And given lguest's lack of interface guarantees, it make sense to use 
it as the first virtio guinea pig.  I expect changes as we adapt it for 
others anyway.

> That reminds me that I promised Rusty to look at one small issue in virtio
> net driver. Nothing that should hold of the merge. I will sent the patch
> via Rusty when its ready.

Thanks,
Rusty.
