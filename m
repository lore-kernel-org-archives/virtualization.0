From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 00/12] gendisk: Generate uevent after attribute
	available
Date: Thu, 30 Jun 2016 18:29:31 -0700
Message-ID: <CAA9_cmeb99S+UoZ7A-4HHmT_rFRgnSaBX=YszEk8+4_=n9cOnA__9691.80210163376$1467395570$gmane$org@mail.gmail.com>
References: <20160630015953.6888-1-famz@redhat.com>
	<20160630062442.GA19761@infradead.org>
	<20160630063554.GE23296@ad.usersys.redhat.com>
	<20160630063839.GA17205@infradead.org>
	<20160701010113.GB10122@ad.usersys.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160701010113.GB10122@ad.usersys.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fam Zheng <famz@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org, Keith Busch <keith.busch@intel.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@infradead.org>, Shaohua Li <shli@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Jiri Kosina <jikos@kernel.org>, linux-raid <linux-raid@vger.kernel.org>, "Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Minchan Kim <minchan@kernel.org>, linux-mtd@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>linuxppc-dev <li>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 30, 2016 at 6:01 PM, Fam Zheng <famz@redhat.com> wrote:
> On Wed, 06/29 23:38, Christoph Hellwig wrote:
>> On Thu, Jun 30, 2016 at 02:35:54PM +0800, Fam Zheng wrote:
>> > also more code and less flexible IMO.  For example, we need at least two
>> > variants, for attribute_group and device_attribute separately, right?
>>
>> Yes, or maybe just a calling convention that just passes both.
>
> OK, I can look into that, but I'm not sure about the error handling. Currently
> add_disk returns void, do you have any plan on that too? should I change it in
> v3 (to at least return the attribute creation failure)?

I think we should only support a "groups" interface to
device_add_disk() and convert all the drivers that currently do
device_create_file() after add_disk() to pass in a group list instead.
That way we follow the expectation that the only way to get an
attribute for a device to show up before KOBJ_ADD, is to define a
group:

From Documentation/driver-model/device.txt:
    As explained in Documentation/kobject.txt, device attributes must be be
    created before the KOBJ_ADD uevent is generated. The only way to realize
    that is by defining an attribute group.

Let's defer the return value fixing for now.

You can find the pending device_add_disk() patches in the nvdimm
patchwork starting with "block: introduce device_add_disk()"

https://patchwork.kernel.org/project/linux-nvdimm/list/
