From: "Liu, Jinsong" <jinsong.liu@intel.com>
Subject: RE: xen/acpi: ACPI memory hotplug
Date: Sun, 17 Feb 2013 07:25:21 +0000
Message-ID: <DE8DF0795D48FD4CA783C40EC82923353FCC82__32858.1121903428$1361231798$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <20130215141728.GA27966@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130215141728.GA27966@elgon.mountain>
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
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "kbuild@01.org" <kbuild@01.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Dan Carpenter wrote:
> Hello Liu Jinsong,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 259f201cb7ea: "xen/acpi: ACPI memory hotplug" from Jan 24,
> 2013, leads to the following Smatch complaint:
> 
> drivers/xen/xen-acpi-memhotplug.c:198 acpi_memory_get_device()
> 	 error: we previously assumed 'device' could be null (see line 171)
> 
> drivers/xen/xen-acpi-memhotplug.c
>    170
>    171		if (!acpi_bus_get_device(handle, &device) && device)
>                                                              ^^^^^^
> New check.
> 
> Btw, checking device is unnecessary.
> 
> 		if (acpi_bus_get_device(handle, &device) == 0)
> 			goto end;
> 
> A successful "Get Device" means that "device" is non-NULL; that's
> built into the name.  Anyway, if acpi_bus_get_device() fails either
> something else will fail or we will Oops in the call to
> acpi_driver_data(). 
> 
>    172			goto end;
>    173
>    174		status = acpi_get_parent(handle, &phandle);
>    175		if (ACPI_FAILURE(status)) {
>    176			pr_warn(PREFIX "Cannot find acpi parent\n");
>    177			return -EINVAL;
>    178		}
>    179
>    180		/* Get the parent device */
>    181		result = acpi_bus_get_device(phandle, &pdevice);
>    182		if (result) {
>    183			pr_warn(PREFIX "Cannot get acpi bus device\n");
>    184			return -EINVAL;
>    185		}
>    186
>    187		/*
>    188		 * Now add the notified device.  This creates the acpi_device
>    189		 * and invokes .add function
>    190		 */
>    191		result = acpi_bus_scan(handle);
>    192		if (result) {
>    193			pr_warn(PREFIX "Cannot add acpi bus\n");
>    194			return -EINVAL;
>    195		}
>    196
>    197	end:
>    198		*mem_device = acpi_driver_data(device);
>                                                ^^^^^^
> Dereference.
> 
>    199		if (!(*mem_device)) {
>    200			pr_err(PREFIX "Driver data not found\n");
> 
> regards,
> dan carpenter

Thanks Dan, updated, will send out minutes later.

Regards,
Jinsong
