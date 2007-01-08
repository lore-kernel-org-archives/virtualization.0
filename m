From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch] asm/i386/kernel/paravirt.c buildfix
Date: Mon, 8 Jan 2007 12:02:02 -0800
Message-ID: <20070108200202.GB19575@sequoia.sous-sol.org>
References: <20070108152852.7819D1ED200@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
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
To: Gers Knorr <kraxel@suse.de>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

* Gers Knorr (kraxel@suse.de) wrote:
> asm/i386/kernel/paravirt.c buildfix.
> =

> drop apic_* duplicates which are defined in asm/paravirt.h

Thanks, but did you build test w/ smth like allmodconfig (paravirt_ops
not being exported anymore means those inline wrappers can easily break)?

thanks,
-chris
