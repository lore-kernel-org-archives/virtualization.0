From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] KVM: Add Kconfig option to signal cross-endian guests
Date: Thu, 9 Jul 2015 14:21:54 +0200
Message-ID: <20150709142154.5561fa16.cornelia.huck__28145.2710660689$1436444544$gmane$org@de.ibm.com>
References: <20150707195012-mutt-send-email-mst@redhat.com>
	<1436428145-29823-1-git-send-email-thuth@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1436428145-29823-1-git-send-email-thuth@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Gleb Natapov <gleb@kernel.org>, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, virtualization@lists.linux-foundation.org, Marc Zyngier <marc.zyngier@arm.com>, Paul Mackerras <paulus@samba.org>, Christoffer Dall <christoffer.dall@linaro.org>, netdev@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu,  9 Jul 2015 09:49:05 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The option for supporting cross-endianness legacy guests in

s/cross-endianness/cross-endian/ ?

> the vhost and tun code should only be available on systems
> that support cross-endian guests.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/arm/kvm/Kconfig     | 1 +
>  arch/arm64/kvm/Kconfig   | 1 +
>  arch/powerpc/kvm/Kconfig | 1 +
>  drivers/net/Kconfig      | 1 +
>  drivers/vhost/Kconfig    | 1 +
>  virt/kvm/Kconfig         | 3 +++
>  6 files changed, 8 insertions(+)

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
