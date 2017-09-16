From: Laura Abbott <labbott@redhat.com>
Subject: Re: Regression in virtio block driver with 4.13.2
Date: Sat, 16 Sep 2017 16:16:06 -0700
Message-ID: <db314009-f47f-17bc-e2d6-d84936432575@redhat.com>
References: <93e65aef-e93d-6a99-854a-f6147f84e3b1@redhat.com>
	<20170915173703.GA23073@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170915173703.GA23073@infradead.org>
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

On 09/15/2017 10:37 AM, Christoph Hellwig wrote:
> On Fri, Sep 15, 2017 at 09:54:08AM -0700, Laura Abbott wrote:
>> Hi,
>>
>> Fedora got a bug report on an early version of 4.13.2
>> https://paste.fedoraproject.org/paste/t-Yx23LN5QwJ7oPZLj3zrg
> 
> Can you check if the issue goes away when you disable
> CONFIG_VIRTIO_BLK_SCSI?
> 

Yes, the issue goes  away when CONFIG_VIRTIO_BLK_SCSI is
disabled.

Thanks,
Laura
