From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] Install udev rules in system-default directory
Date: Tue, 19 Aug 2014 19:20:20 +0200
Message-ID: <53F38754.2050808@redhat.com>
References: <cover.1407416628.git.amit.shah@redhat.com>
	<3df55388b1b3acd142f391494f102c3ddb2270ed.1407416628.git.amit.shah__45224.3810439997$1407417016$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <3df55388b1b3acd142f391494f102c3ddb2270ed.1407416628.git.amit.shah__45224.3810439997$1407417016$gmane$org@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, jgarzik@bitpay.com
Cc: hpa@linux.intel.com, linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Il 07/08/2014 15:09, Amit Shah ha scritto:
> +udevrules_DATA	 = 90-virtio-rng.rules

If rng-tools is packaged with "make dist" you need this to be

dist_udevrules_DATA	 = 90-virtio-rng.rules

or alternatively

EXTRA_DIST = 90-virtio-rng.rules
udevrules_DATA	 = 90-virtio-rng.rules

> +AC_ARG_WITH([udevrulesdir],
> +	AS_HELP_STRING([--with-udevrulesdir=DIR], [Directory for udev rules]),
> +	[],
> +	[with_udevrulesdir=$($PKG_CONFIG --variable=udevdir udev)"/rules.d"])
> +AC_SUBST([udevrulesdir], [$with_udevrulesdir])

You can use AM_CONDITIONAL to skip the installation if
$with_udevrulesdir is "no" (aka --without-udevrulesdir).  Then you'd have

EXTRA_DIST = 90-virtio-rng.rules
if INSTALL_UDEV_RULES
udevrules_DATA	 = 90-virtio-rng.rules
endif

I don't know offhand if this works:

if INSTALL_UDEV_RULES
dist_udevrules_DATA	 = 90-virtio-rng.rules
endif

but I think so; you can check with "./configure --without-udevrulesdir
&& make && make dist".

Thanks,

Paolo
