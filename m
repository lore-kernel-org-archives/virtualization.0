From: Avi Kivity <avi@qumranet.com>
Subject: Re: [RFC 1/4] New virtio bus driver
Date: Mon, 09 Jul 2007 09:49:13 +0300
Message-ID: <4691DA69.4060204@qumranet.com>
References: <20070706124200.988637662@arndb.de>
	<200707081729.58461.arnd@arndb.de> <4691076B.5050106@qumranet.com>
	<200707082229.00810.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200707082229.00810.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Arnd Bergmann wrote:
> On Sunday 08 July 2007, Avi Kivity wrote:
>
>   
>>> Alternatively, we could have a mechanism separate from the
>>> virtqueue concept, like a synchronous get_config_data/set_config_data
>>> callback into the host driver.
>>>   
>>>       
>> You also need to allow the host to notify the guest about configuration 
>> changes.
>>     
>
> That is much harder to do, it would require a separate interrupt if you
> want to have a device independent mechanism. Most real buses (like PCI)
> don't have this, so I'm not sure it's good to do this at the virtio
> layer. You already listed the media change notification, which can
> be handled without this by either removing and adding the complete
> virtio device, or by using a channel for out-of-band data like scsi.
>  


At the very least, we need an interrupt for device hotplug.  That same
interrupt can be used to notify the guest about configuration changes
within a device ("rescan the virtbus and all who sail in her").

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
