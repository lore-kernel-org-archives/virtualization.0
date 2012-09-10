From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-spec: balloon: MUST_TELL_HOST is optional
Date: Mon, 10 Sep 2012 08:15:31 +0200
Message-ID: <504D8583.2080501@redhat.com>
References: <20120909113650.GA2775@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120909113650.GA2775@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 09/09/2012 13:36, Michael S. Tsirkin ha scritto:
>  \begin_layout Enumerate
> -If the VIRTIO_BALLOON_F_MUST_TELL_HOST feature is set, the guest may not
> - use these requested pages until that descriptor in the deflateq has been
> - used by the device.
> +If the VIRTIO_BALLOON_F_MUST_TELL_HOST feature is 
> +\change_inserted 1986246365 1347188540
> +negotiated
> +\change_deleted 1986246365 1347188542
> +set
> +\change_unchanged
> +, the guest may not use these requested pages until that descriptor in the
> + deflateq has been used by the device.
>  \end_layout

Yeah, that's ok.

Paolo
