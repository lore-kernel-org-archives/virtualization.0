From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [RFC PATCH] virtio: change config to guest endian.
Date: Wed, 23 Apr 2008 07:05:38 +1000
Message-ID: <200804230705.38495.rusty__47484.9810278558$1208898472$gmane$org@rustcorp.com.au>
References: <200804221357.34571.rusty@rustcorp.com.au>
	<200804230031.35760.rusty@rustcorp.com.au>
	<200804221529.14750.hollisb@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804221529.14750.hollisb@us.ibm.com>
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
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 23 April 2008 06:29:14 Hollis Blanchard wrote:
> On Tuesday 22 April 2008 09:31:35 Rusty Russell wrote:
> > We may still regret not doing *everything* little-endian, but this
> > doesn't make it worse.
>
> Hmm, why *don't* we just do everything LE, including the ring?

Mainly because when requirements are in doubt, simplicity wins, I think.

Cheers,
Rusty.
