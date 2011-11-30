From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [ANNOUNCE] Xen port to Cortex-A15 / ARMv7 with virt extensions
Date: Wed, 30 Nov 2011 11:41:58 +0000
Message-ID: <alpine.DEB.2.00.1111301112400.31179@kaball-desktop>
References: <alpine.DEB.2.00.1111281009090.31179@kaball-desktop>
	<201111292129.20444.arnd@arndb.de>
	<CAAhSdy3F1oUQP=f_Tig4_MnufwPRpNooZYW8_cSTAse7aOaDoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAAhSdy3F1oUQP=f_Tig4_MnufwPRpNooZYW8_cSTAse7aOaDoA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anup Patel <anup@brainfault.org>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, Arnd Bergmann <arnd@arndb.de>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "android-virt@lists.cs.columbia.edu" <android-virt@lists.cs.columbia.edu>, "embeddedxen-devel@lists.sourceforge.net" <embeddedxen-devel@lists.sourceforge.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 30 Nov 2011, Anup Patel wrote:
> Hi all,
> 
> I wanted to know how Xen-ARM for A15 will address following concerns:
> 
> - How will Xen-ARM for A15 support legacy guest environment like ARMv5 or ARMv6 ?

It is not our focus at the moment; we are targeting operating systems
that support a modern ARMv7 machine with GIC support. 
That said, it might be possible to run legacy guests in the future,
introducing more emulation to the hypervisor.


> - What if my Cortex-A15 board does not have a GIC with virtualization support ?

We expect most hardware vendors to provide a GIC with virtualization
support. However if they do not, in order to support their boards we'll
have to do more emulation in the hypervisor.
