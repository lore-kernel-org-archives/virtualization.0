From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix CONFIG_PARAVIRT for 2.6.19-rc5-mm1
Date: Thu, 9 Nov 2006 09:14:53 -0800
Message-ID: <20061109091453.ba84ddce.akpm@osdl.org>
References: <1163034102.15681.6.camel@localhost.localdomain>
	<200611090812.37599.ak@suse.de>
	<20061108233904.e631c7c6.akpm@osdl.org>
	<20061109000939.7a48851f.akpm@osdl.org>
	<20061109141109.GA63791@muc.de>
	<20061109091303.7050ea1d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061109091303.7050ea1d.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>, Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 9 Nov 2006 09:13:03 -0800
Andrew Morton <akpm@osdl.org> wrote:

> so I'll send them over now.

You'll need to drop

header-and-stubs-for.patch
paravirt-patch.patch
paravirt-entry.patch
paravirt-bug-skip.patch
paravirt-no-legacy.patch
paravirt-apic.patch
paravirt-tlb.patch
paravirt-broken.patch
paravirt-compile.patch
