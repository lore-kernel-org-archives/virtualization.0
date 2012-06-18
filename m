From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Mon, 18 Jun 2012 13:39:35 +0200
Message-ID: <1340019575.22848.2.camel@lappy>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
	<1340002390-3950-4-git-send-email-asias@redhat.com>
	<87hau9yse7.fsf@rustcorp.com.au> <4FDEE0CB.1030505@redhat.com>
	<87zk81x7dp.fsf@rustcorp.com.au> <4FDF0DA7.40604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4FDF0DA7.40604@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dlaor@redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2012-06-18 at 14:14 +0300, Dor Laor wrote:
> On 06/18/2012 01:05 PM, Rusty Russell wrote:
> > On Mon, 18 Jun 2012 16:03:23 +0800, Asias He<asias@redhat.com>  wrote:
> >> On 06/18/2012 03:46 PM, Rusty Russell wrote:
> >>> On Mon, 18 Jun 2012 14:53:10 +0800, Asias He<asias@redhat.com>  wrote:
> >>>> This patch introduces bio-based IO path for virtio-blk.
> >>>
> >>> Why make it optional?
> >>
> >> request-based IO path is useful for users who do not want to bypass the
> >> IO scheduler in guest kernel, e.g. users using spinning disk. For users
> >> using fast disk device, e.g. SSD device, they can use bio-based IO path.
> >
> > Users using a spinning disk still get IO scheduling in the host though.
> > What benefit is there in doing it in the guest as well?
> 
> The io scheduler waits for requests to merge and thus batch IOs 
> together. It's not important w.r.t spinning disks since the host can do 
> it but it causes much less vmexits which is the key issue for VMs. 

Is the amount of exits caused by virtio-blk significant at all with
EVENT_IDX?
