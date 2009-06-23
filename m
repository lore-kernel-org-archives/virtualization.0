From: Blue Swirl <blauwirbel@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] virtio_serial: A char device for simple
	guest <-> host communication
Date: Tue, 23 Jun 2009 18:15:18 +0300
Message-ID: <f43fc5580906230815o219e3676x2fa078c9ed9db15a__33320.5686569729$1245770460$gmane$org@mail.gmail.com>
References: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
	<1245760953-32139-2-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1245760953-32139-2-git-send-email-amit.shah@redhat.com>
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
> We expose multiple char devices ("ports") for simple communication
>  between the host userspace and guest.
>  +struct virtio_serial_config {
>  +       __u32 nr_ports;
>  +       __u16 status;
>  +} __attribute__((packed));

There is still structure packing. I'd use __u16 for both fields, do
you really need 4 gigs of ports?.
