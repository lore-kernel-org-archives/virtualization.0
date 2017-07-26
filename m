From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH net] Revert "vhost: cache used event for better
	performance"
Date: Wed, 26 Jul 2017 12:53:38 +0200
Message-ID: <da300d74-ca7a-a636-0ed6-6aa78e6a5510__346.795892301266$1501066434$gmane$org@de.ibm.com>
References: <1501056197-3368-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1501056197-3368-1-git-send-email-jasowang@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 07/26/2017 10:03 AM, Jason Wang wrote:
> This reverts commit 809ecb9bca6a9424ccd392d67e368160f8b76c92. Since it
> was reported to break vhost_net. We want to cache used event and use
> it to check for notification. We try to valid cached used event by
> checking whether or not it was ahead of new, but this is not correct
> all the time, it could be stale and there's no way to know about this.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

This would then qualify for stable ?
