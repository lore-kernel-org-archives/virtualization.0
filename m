From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Regression in virtio block driver with 4.13.2
Date: Fri, 15 Sep 2017 10:37:03 -0700
Message-ID: <20170915173703.GA23073__35718.2063431994$1505497046$gmane$org@infradead.org>
References: <93e65aef-e93d-6a99-854a-f6147f84e3b1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <93e65aef-e93d-6a99-854a-f6147f84e3b1@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laura Abbott <labbott@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 15, 2017 at 09:54:08AM -0700, Laura Abbott wrote:
> Hi,
> 
> Fedora got a bug report on an early version of 4.13.2
> https://paste.fedoraproject.org/paste/t-Yx23LN5QwJ7oPZLj3zrg

Can you check if the issue goes away when you disable
CONFIG_VIRTIO_BLK_SCSI?
