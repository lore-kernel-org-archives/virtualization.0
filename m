From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Wed, 15 Nov 2006 14:40:53 -0800
Message-ID: <20061115224053.GO1397@sequoia.sous-sol.org>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com>
	<20061027145650.GA37582@muc.de> <45425976.3090508@vmware.com>
	<200610271416.12548.ak@suse.de> <4546669F.8020706@vmware.com>
	<20061030225016.GA95732@muc.de>
	<20061115080323.GK1397@sequoia.sous-sol.org>
	<455ACDEC.7010808@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <455ACDEC.7010808@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

* Zachary Amsden (zach@vmware.com) wrote:
> I'm a little worried after seeing failures to apply and missed patches =

> that we could have other things missing from the upstream path.  Is =

> there an easy way for us to look at diffs between the trees?  Just a =

> diff on arch/i386 and include/asm-i386 would tell me wonders, no matter =

> how much extra activity has gone on there.

Last night I rebased against 2.6.15-mm2.  I'm adding four patches that
Andrew sent Andi last night.  I'll rediff and see what (if anything) is
outstanding.

thanks,
-chris
