From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH 1/2] virtio-balloon: initialize all vq callbacks
Date: Wed, 18 Dec 2019 11:18:45 +0800
Message-ID: <5DF99A95.8050800@intel.com>
References: <20191217190610.248061-1-dverkamp@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191217190610.248061-1-dverkamp@chromium.org>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 12/18/2019 03:06 AM, Daniel Verkamp wrote:
> Ensure that elements of the array that correspond to unavailable
> features are set to NULL; previously, they would be left uninitialized.
>
> Since the corresponding names array elements were explicitly set to
> NULL, the uninitialized callback pointers would not actually be
> dereferenced; however, the uninitialized callbacks elements would still
> be read in vp_find_vqs_msix() and used to calculate the number of MSI-X
> vectors required.

With your 2nd patch:
if (names[i] && callbacks[i])
     ++nvectors;

It seems this patch isn't necessary as names[i] is already NULL, isn't it?

Best,
Wei
