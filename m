From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
Date: Mon, 5 Nov 2018 23:13:49 -0800
Message-ID: <20181106071349.GA5526__31912.7447823577$1541488308$gmane$org@infradead.org>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
	<6a7f1668-bf2d-0caa-2efd-c8fab5f1db24@redhat.com>
	<CAGF4SLg6+nt+zV4haXys4Wz2dWPDyx7xHXuA+h01NcQ94j0E1A@mail.gmail.com>
	<57eefa62-7e66-786d-441c-5dd6b0d451a5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <57eefa62-7e66-786d-441c-5dd6b0d451a5@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: Vitaly Mayatskih <v.mayatskih@gmail.com>, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 06, 2018 at 10:45:08AM +0800, Jason Wang wrote:
> > Storage industry is shifting away from SCSI, which has a scaling
> > problem.
> 
> 
> Know little about storage. For scaling, do you mean SCSI protocol itself? If
> not, it's probably not a real issue for virtio-scsi itself.

The above is utter bullshit.  There is a big NVMe hype, but it is not
because "SCSI has a scaling problem", but because the industry can sell
a new thing, and the standardization body seems easier to work with.
