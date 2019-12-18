From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] virtio-balloon: initialize all vq callbacks
Date: Wed, 18 Dec 2019 00:19:57 -0500
Message-ID: <20191218001922-mutt-send-email-mst@kernel.org>
References: <20191217190610.248061-1-dverkamp@chromium.org>
 <5DF99A95.8050800@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5DF99A95.8050800@intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 18, 2019 at 11:18:45AM +0800, Wei Wang wrote:
> On 12/18/2019 03:06 AM, Daniel Verkamp wrote:
> > Ensure that elements of the array that correspond to unavailable
> > features are set to NULL; previously, they would be left uninitialized.
> > 
> > Since the corresponding names array elements were explicitly set to
> > NULL, the uninitialized callback pointers would not actually be
> > dereferenced; however, the uninitialized callbacks elements would still
> > be read in vp_find_vqs_msix() and used to calculate the number of MSI-X
> > vectors required.
> 
> With your 2nd patch:
> if (names[i] && callbacks[i])
>     ++nvectors;
> 
> It seems this patch isn't necessary as names[i] is already NULL, isn't it?
> 
> Best,
> Wei

Right but passing uninitialized values isn't nice even if
the function called happens to ignore them.
