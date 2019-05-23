From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 0/4] Prevent vhost kthread from hogging CPU
Date: Thu, 23 May 2019 13:22:32 -0400
Message-ID: <20190523132228-mutt-send-email-mst__3342.24037812731$1558632167$gmane$org@kernel.org>
References: <1558067392-11740-1-git-send-email-jasowang@redhat.com>
	<20190518.132712.1971625204431294331.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190518.132712.1971625204431294331.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Sat, May 18, 2019 at 01:27:12PM -0700, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Fri, 17 May 2019 00:29:48 -0400
> 
> > Hi:
> > 
> > This series try to prevent a guest triggerable CPU hogging through
> > vhost kthread. This is done by introducing and checking the weight
> > after each requrest. The patch has been tested with reproducer of
> > vsock and virtio-net. Only compile test is done for vhost-scsi.
> > 
> > Please review.
> > 
> > This addresses CVE-2019-3900.
> > 
> > Changs from V1:
> > - fix user-ater-free in vosck patch
> 
> I am assuming that not only will mst review this, it will also go via
> his tree rather than mine.
> 
> Thanks.

Will do.
