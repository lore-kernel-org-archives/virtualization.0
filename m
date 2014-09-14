From: Dave Airlie <airlied@gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH 2/2] virtio-gpu/2d: add
	docs/specs/virtio-gpu.txt
Date: Sun, 14 Sep 2014 21:05:09 +1000
Message-ID: <CAPM=9tx6bCncMrr3AB5t5opb_-zsSX5DfWeA755nFPUj2+_s=w@mail.gmail.com>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
	<1410448173-12960-3-git-send-email-kraxel@redhat.com>
	<20140914091613.GB24929@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140914091613.GB24929@redhat.com>
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
Cc: Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
List-Id: virtualization@lists.linuxfoundation.org

On 14 September 2014 19:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Sep 11, 2014 at 05:09:33PM +0200, Gerd Hoffmann wrote:
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  docs/specs/virtio-gpu.txt | 165 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 165 insertions(+)
>>  create mode 100644 docs/specs/virtio-gpu.txt
>
> Please don't put this hardware spec in QEMU.
> Contribute it to OASIS Virtio TC instead.
> If you need help with that, please let me know.

I think we'd be premature in putting this anywhere that isn't
alongside the code until we've addressed at least any resource
allocation or possible security concerns.

Dave.
