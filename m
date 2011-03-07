From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 00/16] Staging: hv: Consolidate driver and device abstractions
Date: Mon,  7 Mar 2011 13:01:35 -0800
Message-ID: <1299531695-22352-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kys@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Hyper-V has maintained both its class independent driver and 
device state in two independent data structures:
Driver state: struct driver_context (vmbus.h) and struct hv_driver
(vmbus_api.h)
Device state: struct vm_device (vmbus.h) and struct hv_device (vmbus_api.h)

While sruct driver_context and struct vm_device embed generic 
Linux abstractions of struct device_driver and struct device respectively; 
the lower level hyperv abstraction: struct hv_driver and struct hv_device
have maintained state needed to communicate with the host. This partitioning
made sense at a point in time when it was not clear how much of 
the hypervisor interaction would be open sourced. Given where we are
today, there is no reason to keep this layering. This patchset 
consolidates all the driver state into a single structure: 
struct hv_driver while all the device state is consolidated into
a single structure: struct hv_device. This consolidation simplifies
the code while simultaneously getting rid of redundant state -
for instance in the current code, both struct driver_context and
struct hv_driver both have state to represent the class as well as
instance id. We do this consolidation by moving state from higher
level structures (struct driver_context and struct vm_device) to
lower level structures (struct hv_driver and hv_device) respectively.

While it has not been a goal of this effort to cleanup structure and 
variable names, this consolidation effort has resulted in some cleanup
with regards to structure and variable names: a) Some of the badly
named structures have been eliminated (struct driver_context etc.) 
while hopefully all newly introduced names are acceptable.  

Patches 1 through 11 deal with consolidating the device driver
state while patches 12 through 16  deal with consolidating
device state.


Regards,

K. Y
