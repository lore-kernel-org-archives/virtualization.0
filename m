From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 09/20] rename struct paravirt_patch to
	paravirt_patch_site for clarity
Date: Fri, 6 Apr 2007 16:18:22 -0700
Message-ID: <20070406161822.a9f828a4.akpm@linux-foundation.org>
References: <20070404191151.009821039@goop.org>
	<20070404191205.617690202@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070404191205.617690202@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 04 Apr 2007 12:12:00 -0700 Jeremy Fitzhardinge <jeremy@goop.org> wr=
ote:

> Rename struct paravirt_patch to paravirt_patch_site, so that it
> clearly refers to a callsite, and not the patch which may be applied
> to that callsite.

Needed a bit of updating for Andi's recently-merged
x86_64-mm-vmi-backend-for-paravirt-ops.patch but I think I got it
right.  We'll see if it compiles.
