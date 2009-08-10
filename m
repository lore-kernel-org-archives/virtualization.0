From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH 0/3] qemu-kvm: vhost net support
Date: Mon, 10 Aug 2009 15:51:12 -0500
Message-ID: <4A808840.70704@codemonkey.ws>
References: <20090810192304.GA16781@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090810192304.GA16781@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> This adds support for vhost-net virtio kernel backend.
>
> This is RFC, but works without issues for me.
>
> Still needs to be split up, tested and benchmarked properly,
> but posting it here in case people want to test drive
> the kernel bits I posted.
>   

Any rough idea on performance?  Better or worse than userspace?

Regards,

Anthony Liguori
