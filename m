From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] asm/i386/kernel/paravirt.c buildfix
Date: Tue, 09 Jan 2007 10:18:51 +1100
Message-ID: <1168298331.19646.44.camel@localhost.localdomain>
References: <20070108152852.7819D1ED200@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070108152852.7819D1ED200@linux.local>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Gers Knorr <kraxel@suse.de>, Chris Wright <chrisw@sous-sol.org>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-01-08 at 16:28 +0100, Gers Knorr wrote:
> asm/i386/kernel/paravirt.c buildfix.
> =

> drop apic_* duplicates which are defined in asm/paravirt.h

How did this segment get dropped from the patch I sent?

The correct answer is to remove the header versions, as Chris did.

Thanks!
Rusty.
