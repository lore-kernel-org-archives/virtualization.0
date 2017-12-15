From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/3] virtio_pci: use put_device instead of kfree
Date: Fri, 15 Dec 2017 13:32:56 +0100
Message-ID: <20171215133256.4262ac9d.cohuck@redhat.com>
References: <cover.1513083885.git.zhangweiping@didichuxing.com>
	<e397f504c0a796481d8aaf0e558cc8425286012c.1513083885.git.zhangweiping@didichuxing.com>
	<20171214205538-mutt-send-email-mst@kernel.org>
	<CAA70yB4jyroEGd+rKHMA_AJ93JGTC8Q4qADBs87q3z7x9XwEMQ@mail.gmail.com>
	<20171215034700-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171215034700-mutt-send-email-mst@kernel.org>
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
Cc: Greg Kroah-Hartman <gregkh@suse.de>, weiping zhang <zhangweiping@didichuxing.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 15 Dec 2017 03:48:09 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Also just to make sure, none of this is a regression and none
> of this causes actual known issues right?
> 
> I think it's preferrable to defer to next merge cycle unless this
> is a regression.

I noticed this while looking at the cleanup path for
regsiter_virtio_device(), I don't think any actual problems have been
seen in the wild (just a latent bug). Deferring to the next merge
window seems reasonable.
