From: Don Mullis <dwm@meer.net>
Subject: Re: [PATCH] Re: [PATCH 3/4] Prep for paravirt: desc.h clearer
	parameter names, some code motion
Date: Sun, 29 Oct 2006 13:44:19 -0800
Message-ID: <1162158259.23311.35.camel@localhost.localdomain>
References: <1161920325.17807.29.camel@localhost.localdomain>
	<1161920728.17807.39.camel@localhost.localdomain>
	<1162152071.23311.28.camel@localhost.localdomain>
	<200610291306.36148.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <200610291306.36148.ak@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2006-10-29 at 13:06 -0800, Andi Kleen wrote:
> On Sunday 29 October 2006 12:01, Don Mullis wrote:
> > Fix build where CONFIG_CC_OPTIMIZE_FOR_SIZE is not set.
> >
> > Tested by build and boot.
> =

> What error does that fix?

The build aborts with:

  include/asm/desc.h: In function 'set_ldt':
  include/asm/desc.h:92: error: implicit declaration of function 'write_gdt=
_entry'

The patch is a follow-on to my earlier reply to "[PATCH 1/4]".

DM
