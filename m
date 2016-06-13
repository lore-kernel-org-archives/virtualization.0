From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] virtio_balloon: fix PFN format for virtio-1
Date: Mon, 13 Jun 2016 09:15:44 +0200
Message-ID: <575E5DA0.1080906__14129.1245622144$1465813031$gmane$org@de.ibm.com>
References: <1463574848-15630-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1463574848-15630-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/18/2016 02:38 PM, Michael S. Tsirkin wrote:
> Everything should be LE when using virtio-1, but
> the linux balloon driver does not seem to care about that.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

The final commit in Linus tree does not contain cc stable
see
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=87c9403b0d1de4676b0bd273eea68fcf6de68e68

But it is certainly table material.

Christian
