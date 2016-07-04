From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Build regressions/improvements in v4.7-rc6
Date: Mon, 4 Jul 2016 13:06:54 +0200
Message-ID: <f2b404d1-5212-8698-c8dd-c94e34160a70@redhat.com>
References: <1467619946-424-1-git-send-email-geert@linux-m68k.org>
	<CAMuHMdUDO0k86TTVTiCQGS2=H0dEXVW77NNfvt7fvWbwdpS=2g@mail.gmail.com>
	<6183003.0tbSMroAbk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <6183003.0tbSMroAbk@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 04/07/2016 11:17, Arnd Bergmann wrote:
> 
> If we want to avoid this one, we could make the inclusion of
> drivers/vhost/Kconfig from arch/arm/kvm/Kconfig depend on CONFIG_AEABI,
> or perhaps go further force-enable CONFIG_AEABI for ARMv6k and higher
> (cmpxchg64() is broken on OABI too), and only include vhost if KVM
> is enabled (KVM in turn requires ARMv7).

I don't think it is correct to include vhost only if KVM is enabled.
vhost is an implementation of virtio; it is usually used together with
KVM but there's no dependency between the two.

Paolo
