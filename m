From: Blue Swirl <blauwirbel@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-serial: virtio device for simple host
	<-> guest communication
Date: Tue, 23 Jun 2009 18:19:30 +0300
Message-ID: <f43fc5580906230819u751e746dmbd97c52a77992993__38600.643273867$1245770581$gmane$org@mail.gmail.com>
References: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
	<1245760953-32139-2-git-send-email-amit.shah@redhat.com>
	<1245760953-32139-3-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1245760953-32139-3-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 6/23/09, Amit Shah <amit.shah@redhat.com> wrote:
> This interface presents a char device from which bits can be
>  sent and read.

>  +struct virtio_serial_config
>  +{
>  +    uint32_t nr_ports;
>  +    uint16_t status;
>  +} __attribute__((packed));

Obviously this has to match the kernel structure if you go for 16 bit nr_ports.
