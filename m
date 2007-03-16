From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] make CONFIG_PARAVIRT require NO_HZ
Date: Fri, 16 Mar 2007 11:55:38 +0100
Message-ID: <20070316105538.GA13557@elte.hu>
References: <20070316054746.GD10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070316054746.GD10574@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: virtualization@lists.osdl.org, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Chris Wright <chrisw@sous-sol.org> wrote:

> Given all the discussion, let's just require NO_HZ when =

> CONFIG_PARAVIRT.  Anyone object?

well ... why do we want this? I'd not mind making it default y if =

CONFIG_PARAVIRT is enabled, but why force it?

	Ingo
