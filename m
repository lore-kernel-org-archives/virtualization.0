From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v1 0/2] Virtio: fix some vq allocation issues
Date: Mon, 31 Dec 2018 06:03:51 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DEEC8DF@shsmsx102.ccr.corp.intel.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
	<c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
	<286AC319A985734F985F78AFA26841F73DEEA8E9@shsmsx102.ccr.corp.intel.com>
	<20181230070600.512bbb8b@oc2783563651>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181230070600.512bbb8b@oc2783563651>
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
To: 'Halil Pasic' <pasic@linux.ibm.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sunday, December 30, 2018 2:06 PM, Halil Pasic wrote:
> 
> I guess you are the first one trying to read virtio config from within interrupt
> context. AFAICT this never worked.

I'm not sure about "never worked". It seems to work well with virtio-pci.
But looking forward to hearing a solid reason why reading config inside
the handler is forbidden (if that's true).

> About what happens. The apidoc of ccw_device_start() says it needs to be
> called with the ccw device lock held, so ccw_io_helper() tries to take it (since
> forever I guess). OTOH do_cio_interrupt() takes the subchannel lock and
> io_subchannel_initialize_dev() makes the ccw device lock be the subchannel
> lock. That means when one tries to get virtio config form within a cio
> interrupt context we deadlock, because we try to take a lock we already have.
> 
> That said, I don't think this limitation is by design (i.e. intended).
> Maybe Connie can help us with that question. AFAIK we have nothing
> documented regarding this (neither that can nor can't).
> 
> Obviously, there are multiple ways around this problem, and at the moment
> I can't tell which would be my preferred one.

Yes, it's also not difficult to tweak the virtio-balloon code to avoid that issue.
But if that's just an issue with ccw itself, I think it's better to tweak ccw and
remain virtio-balloon unchanged.

Best,
Wei
