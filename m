From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH] virtio-balloon: request nvqs based on features
Date: Tue, 17 Dec 2019 10:00:30 +0800
Message-ID: <5DF836BE.4040108@intel.com>
References: <20191216231429.38202-1-dverkamp@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191216231429.38202-1-dverkamp@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Daniel Verkamp <dverkamp@chromium.org>, virtualization@lists.linux-foundation.org
Cc: Liang Li <liang.z.li@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 12/17/2019 07:14 AM, Daniel Verkamp wrote:
> After 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT"),
> the virtio-balloon device unconditionally specifies 4 virtqueues as the
> argument to find_vqs(), which means that 5 MSI-X vectors are required in
> order to assign one vector per VQ plus one for configuration changes.
>
> However, in cases where the virtio device only provides exactly as many
> MSI-X vectors as required for the features it implements (e.g. 3 for the
> basic configuration of inflate + deflate + config), this results in the
> selection of the fallback configuration where one interrupt vector is
> used for all VQs instead of having one VQ per vector.

I'm not sure if I get the above. Virtio won't do any vq allocation for
the one that has "callbacks[i] = NULL", so no msi-x vector will be
assigned for it.

Btw, did you trigger any bug with the existing code?

Best,
Wei
