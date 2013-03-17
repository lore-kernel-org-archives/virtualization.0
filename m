From: Kevin O'Connor <kevin@koconnor.net>
Subject: Re: [PATCH 0/2] Fix booting tcm_vhost + seabios
Date: Sun, 17 Mar 2013 10:28:52 -0400
Message-ID: <20130317142852.GA18191__22664.5615454347$1363647008$gmane$org@morn.localdomain>
References: <1363311916-23121-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363311916-23121-1-git-send-email-asias@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, seabios@seabios.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 15, 2013 at 09:45:14AM +0800, Asias He wrote:
> Asias He (2):
>   virtio-scsi: Set _DRIVER_OK flag before scsi target scanning
>   virtio-scsi: Pack struct virtio_scsi_{req_cmd,resp_cmd}

Thanks.  I pushed these patches.

-Kevin
