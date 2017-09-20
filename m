From: Laura Abbott <labbott@redhat.com>
Subject: Re: Regression in virtio block driver with 4.13.2
Date: Tue, 19 Sep 2017 17:15:47 -0700
Message-ID: <227487f8-3b7a-a431-da32-890f4a73732b@redhat.com>
References: <93e65aef-e93d-6a99-854a-f6147f84e3b1@redhat.com>
	<20170915173703.GA23073@infradead.org>
	<db314009-f47f-17bc-e2d6-d84936432575@redhat.com>
	<20170917235731.GA31789@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170917235731.GA31789@infradead.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/17/2017 04:57 PM, Christoph Hellwig wrote:
> On Sat, Sep 16, 2017 at 04:16:06PM -0700, Laura Abbott wrote:
>> Yes, the issue goes  away when CONFIG_VIRTIO_BLK_SCSI is
>> disabled.
> 
> Ok, so it's probably related to follow ups to the scsi_request split.
> 
> That being said, I would highly recommend turning off
> CONFIG_VIRTIO_BLK_SCSI in fedora.  The feature has caused more trouble
> than it helped with, and should never have been added (saying that as
> the person who added it). It was never supported with virtio 1.0 devices
> and has been disabled in qemu by default for quite a while.
> 

Thanks for the pointer, I went and turned it off on our 4.13 based
kernels.

Laura
