From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/3] virtio-net: Use virtio_config_val() for retrieving
	config
Date: Mon, 15 Aug 2011 10:28:05 +0930
Message-ID: <87pqk77aoy.fsf__3526.93541576645$1313370174$gmane$org@rustcorp.com.au>
References: <1313333553-23086-1-git-send-email-levinsasha928@gmail.com>
	<1313333553-23086-3-git-send-email-levinsasha928@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1313333553-23086-3-git-send-email-levinsasha928@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org, Sasha Levin <levinsasha928@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 14 Aug 2011 17:52:33 +0300, Sasha Levin <levinsasha928@gmail.com> wrote:
> This patch modifies virtio-net to use virtio_config_val() instead
> of a 'if(virtio_has_feature()) vdev->config->get()' construct to retrieve
> optional values from the config space.

Thanks, all applied.

Cheers,
Rusty.
