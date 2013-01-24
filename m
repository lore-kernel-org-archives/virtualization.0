From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH V6 1/3] virtio-net: fix the set affinity bug when CPU
	IDs are not consecutive
Date: Thu, 24 Jan 2013 10:28:55 +0800
Message-ID: <51009C67.3090809__24111.7226462395$1358994915$gmane$org@cn.fujitsu.com>
References: <1358767524-17934-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<87hamavx4n.fsf@rustcorp.com.au>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87hamavx4n.fsf@rustcorp.com.au>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Eric Dumazet <erdnetdev@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 01/22/2013 09:12 AM, Rusty Russell wrote:
> Wanlong Gao <gaowanlong@cn.fujitsu.com> writes:
> 
>> As Michael mentioned, set affinity and select queue will not work very
>> well when CPU IDs are not consecutive, this can happen with hot unplug.
>> Fix this bug by traversal the online CPUs, and create a per cpu variable
>> to find the mapping from CPU to the preferable virtual-queue.
> 
> This series looks fairly sane at a glance, to me, but MST is the Ack you
> need.

Hi Michael,

Any comments?

Thanks,
Wanlong Gao

> 
> Thanks,
> Rusty.
> 
