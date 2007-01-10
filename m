From: Zachary Amsden <zach@vmware.com>
Subject: Re: APIC clock setup dependent on PAE ?
Date: Wed, 10 Jan 2007 13:54:34 -0800
Message-ID: <45A5609A.4070201@vmware.com>
References: <Pine.LNX.4.64.0701100933220.8582@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701100933220.8582@d.namei>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: James Morris <jmorris@namei.org>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

James Morris wrote:
> Why are these APIC clock init hooks dependent on CONFIG_X86_PAE ?
>
> include/asm/paravirt.h:
>
> static inline void setup_boot_clock(void)
> {
>         paravirt_ops.setup_boot_clock();
> }
>
> static inline void setup_secondary_clock(void)
> {
>         paravirt_ops.setup_secondary_clock();
> }
>
>
> (via the vmi timer patch).
>   =


Um, that is nuts.  What tree are you in?

Zach
