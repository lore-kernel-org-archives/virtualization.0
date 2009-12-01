From: Avi Kivity <avi@redhat.com>
Subject: Re: virtio: Add memory statistics reporting to the balloon driver (V4)
Date: Tue, 01 Dec 2009 16:56:36 +0200
Message-ID: <4B152EA4.7080207__24943.2092336521$1259679497$gmane$org@redhat.com>
References: <1259597655.30369.2.camel@aglitke>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259597655.30369.2.camel@aglitke>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Adam Litke <agl@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 11/30/2009 06:14 PM, Adam Litke wrote:
> Changes since V3:
>   - Do not do endian conversions as they will be done in the host
>   - Report stats that reference a quantity of memory in bytes
>   - Minor coding style updates
>
> Changes since V2:
>   - Increase stat field size to 64 bits
>   - Report all sizes in kb (not pages)
>   - Drop anon_pages stat and fix endianness conversion
>
> Changes since V1:
>   - Use a virtqueue instead of the device config space
>
> When using ballooning to manage overcommitted memory on a host, a system for
> guests to communicate their memory usage to the host can provide information
> that will minimize the impact of ballooning on the guests.  The current method
> employs a daemon running in each guest that communicates memory statistics to a
> host daemon at a specified time interval.  The host daemon aggregates this
> information and inflates and/or deflates balloons according to the level of
> host memory pressure.  This approach is effective but overly complex since a
> daemon must be installed inside each guest and coordinated to communicate with
> the host.  A simpler approach is to collect memory statistics in the virtio
> balloon driver and communicate them directly to the hypervisor.
>
> This patch enables the guest-side support by adding stats collection and
> reporting to the virtio balloon driver.
>
>    

What about a spec update?  Did that happen and I just missed it?

-- 
error compiling committee.c: too many arguments to function
