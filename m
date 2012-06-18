From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Mon, 18 Jun 2012 13:13:49 +0300
Message-ID: <20120618101349.GC23134@redhat.com>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
	<1340002390-3950-4-git-send-email-asias@redhat.com>
	<87hau9yse7.fsf@rustcorp.com.au> <4FDEE0CB.1030505@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FDEE0CB.1030505@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 18, 2012 at 04:03:23PM +0800, Asias He wrote:
> On 06/18/2012 03:46 PM, Rusty Russell wrote:
> >On Mon, 18 Jun 2012 14:53:10 +0800, Asias He <asias@redhat.com> wrote:
> >>This patch introduces bio-based IO path for virtio-blk.
> >
> >Why make it optional?
> 
> request-based IO path is useful for users who do not want to bypass
> the IO scheduler in guest kernel, e.g. users using spinning disk.
> For users using fast disk device, e.g. SSD device, they can use
> bio-based IO path.

OK I guess but then it should be per-device. There could be
a mix of slow and fast disks :)

> -- 
> Asias
> 
