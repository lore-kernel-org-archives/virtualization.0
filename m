From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio_net and SMP guests
Date: Wed, 26 Dec 2007 11:48:12 +1100
Message-ID: <200712261148.12628.rusty__45390.9893324182$1198630220$gmane$org@rustcorp.com.au>
References: <200712141312.05562.borntraeger@de.ibm.com>
	<200712241154.20885.rusty@rustcorp.com.au>
	<4770F60D.4010904@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4770F60D.4010904@qumranet.com>
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
To: dor.laor@qumranet.com
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 25 December 2007 23:22:37 Dor Laor wrote:
> btw: I checked your Linux tree and found it a bit old, there was no tx
> coalescing timer, it's probably good
> for 2.6.24. Do you plan to post patchset for 25 windows?
> Thanks,
> Dor

Hmm, should be updated now.  Will be pushing all these virtio patches for 
2.6.25...

Cheers,
Rusty.
