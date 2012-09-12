From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH v2 2/2] virtio-ring: Allocate indirect buffers from cache
	when possible
Date: Wed, 12 Sep 2012 12:44:47 +0200
Message-ID: <5050679F.9030002@gmail.com>
References: <1346159043-16446-2-git-send-email-levinsasha928@gmail.com>
	<20120906084526.GE17656@redhat.com>
	<87txvahfv3.fsf@rustcorp.com.au>
	<14037987.hiN6MSGY6z@tomlt1.ibmoffice.com>
	<87bohbdb0o.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87bohbdb0o.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, avi@redhat.com, Thomas Lendacky <tahm@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/12/2012 08:13 AM, Rusty Russell wrote:
> The real question is now whether we'd want a separate indirect cache for
> the 3 case (so num above should be a bitmap?), or reuse the same one, or
> not use it at all?
> 
> Benchmarking will tell...

Since there are no specific decisions about actual values, I'll just modify the
code to use cache per-vq instead of per-device.


Thanks,
Sasha
