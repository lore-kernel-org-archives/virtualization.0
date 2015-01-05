From: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [PATCH 0/3] virtio_pci: fix DEBUG_KOBJECT_RELEASE
Date: Mon, 05 Jan 2015 13:47:20 -0500
Message-ID: <54AADC38.2010508@oracle.com>
References: <1420386340-7719-1-git-send-email-mst@redhat.com>
	<20150104162100.GA8153@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150104162100.GA8153@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/04/2015 11:21 AM, Michael S. Tsirkin wrote:
> On Sun, Jan 04, 2015 at 06:02:13PM +0200, Michael S. Tsirkin wrote:
>> > This is based on Sasha's patch, with some tweaks.
>> > 
> 
> Sasha, I would appreciate it if you can send
> a Tested-by tag to confirm this + the del_vqs
> idempotent patches are sufficient to address
> all issues you have with 3.19.

I've tested the series, which fixed the issues I've reported:

	Tested-by: Sasha Levin <sasha.levin@oracle.com>


Thanks,
Sasha
