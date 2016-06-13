From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] virtio_balloon: fix PFN format for virtio-1
Date: Mon, 13 Jun 2016 20:50:54 +0200
Message-ID: <575F008E.9040601__21942.4836607233$1465843908$gmane$org@de.ibm.com>
References: <1463574848-15630-1-git-send-email-mst@redhat.com>
	<20160613210800-mutt-send-email-mst@redhat.com>
	<20160613183559.GA10149@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160613183559.GA10149@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 06/13/2016 08:35 PM, Greg KH wrote:
> On Mon, Jun 13, 2016 at 09:08:44PM +0300, Michael S. Tsirkin wrote:
>> On Wed, May 18, 2016 at 03:38:53PM +0300, Michael S. Tsirkin wrote:
>>> Everything should be LE when using virtio-1, but
>>> the linux balloon driver does not seem to care about that.
>>>
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> Forgot to CC stable.
>> Please consider this patch for inclusion in the next stable Linux.
> 
> Someone needs to tell stable@ the git comit id of the patch when it hits
> Linus's tree...
> 
> thanks,
> 
> greg k-h
> 

See my mail,
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=87c9403b0d1de4676b0bd273eea68fcf6de68e68

commit	87c9403b0d1de4676b0bd273eea
virtio_balloon: fix PFN format for virtio-1
