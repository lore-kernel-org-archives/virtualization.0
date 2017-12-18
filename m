From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] virtio/s390: fixup for implement PM operations for
	virtio_ccw
Date: Mon, 18 Dec 2017 09:49:48 +0100
Message-ID: <20171218094948.13f3f1ba.cohuck__37721.6503410184$1513586879$gmane$org@redhat.com>
References: <201712171200.w6OAf5Jm%fengguang.wu@intel.com>
	<20171218083706.223836-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171218083706.223836-1-borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, virtualization@lists.linux-foundation.org, kbuild-all@01.org, kbuild test robot <fengguang.wu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 18 Dec 2017 09:37:06 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> We need to disable the pm callbacks if CONFIG_PM is not set.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
> Cornelia, you might want to squash this into the original commit.

Thanks, will do.

> 
>  drivers/s390/virtio/virtio_ccw.c | 4 ++++
>  1 file changed, 4 insertions(+)
