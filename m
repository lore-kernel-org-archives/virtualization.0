From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 6/8] mdev: introduce virtio device and its device ops
Date: Thu, 26 Sep 2019 04:21:31 -0400
Message-ID: <20190926042102-mutt-send-email-mst__18605.4805455328$1569486123$gmane$org@kernel.org>
References: <20190924135332.14160-1-jasowang@redhat.com>
	<20190924135332.14160-7-jasowang@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D58F7DA@SHSMSX104.ccr.corp.intel.com>
	<2210d23d-38e4-e654-e53d-7867348de86a@redhat.com>
	<20190925092044-mutt-send-email-mst@kernel.org>
	<eb7c76b5-2938-2e73-d847-b174a289c5c9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <eb7c76b5-2938-2e73-d847-b174a289c5c9@redhat.com>
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
Cc: "christophe.de.dinechin@gmail.com" <christophe.de.dinechin@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "airlied@linux.ie" <airlied@linux.ie>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "farman@linux.ibm.com" <farman@linux.ibm.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sebott@linux.ibm.com" <sebott@linux.ibm.com>, "lulu@redhat.com" <lulu@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, haotian.
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 26, 2019 at 12:04:46PM +0800, Jason Wang wrote:
> > > > I'm not sure how stable above ops are.
> > > It's the kernel internal API, so there's no strict requirement for this. We
> > > will export a version value for userspace for compatibility.
> > Given it's tied to virtio we probably want kernel+userspace
> > feature bits?
> 
> 
> Yes, then I think we could probably have a version field inside e.g
> device_ops structure. Then it could be fetched from both kernel and
> userspace driver.
> 
> Thanks
> 


my point was feature bits not a version number.

> > 
