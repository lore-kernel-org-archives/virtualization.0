From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [Xen-devel] [patch 07/20] XEN-paravirt: paravirt shared
	kernel pmd flag
Date: Mon, 15 Jan 2007 08:59:01 +0000
Message-ID: <45AB5065.76E4.0078.0@novell.com>
References: <20070113014539.408244126@goop.org>
	<20070113014647.796412179@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070113014647.796412179@goop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chris@sous-sol.org>, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

>>> Jeremy Fitzhardinge <jeremy@goop.org> 13.01.07 02:45 >>>
>Xen does not allow guests to have the kernel pmd shared between page
>tables, so parameterize pgtable.c to allow both modes of operation.

I don't think the change to vmalloc_sync_all in this patch is necessary -
the mechanism exists solely for dealing with modular users of the die
notifier in the NMI case. Since there's no NMI visible to guests, I don't
think the mechanism is necessary; it could even be completely
circumvented for paravirtual guests.

Jan
