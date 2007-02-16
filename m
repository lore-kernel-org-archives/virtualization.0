From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 00/21] Xen-paravirt: Xen guest implementation for
	paravirt_ops interface
Date: Thu, 15 Feb 2007 22:59:32 -0800
Message-ID: <20070215225932.11a1b43e.akpm@linux-foundation.org>
References: <20070216022449.739760547@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070216022449.739760547@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 15 Feb 2007 18:24:49 -0800 Jeremy Fitzhardinge <jeremy@goop.org> wr=
ote:

> This patch series implements the Linux Xen guest in terms of the
> paravirt-ops interface.

The whole patchset exports 67 symbols to modules.  How come?

Are they all needed?
