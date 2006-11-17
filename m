From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Fri, 17 Nov 2006 06:05:19 +0100
Message-ID: <200611170605.19360.ak@muc.de>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com>
	<20061116145313.d7b2240b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061116145313.d7b2240b.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


> Andi seems to have merged this patch but from somewhere I picked up a
> different version, below.
> =

> I think the version I have is better.  Because the patch Andi has merged =
is
> cast in terms of "irq testing", which is broad.  But that's not what the
> patch does - the patch handles only timers.

Agreed. I updated to your version now.

-Andi
