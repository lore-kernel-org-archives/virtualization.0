From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: Re: [PATCH 12/15 v5] PCI: support the SR-IOV capability
Date: Wed, 22 Oct 2008 11:05:26 +0800
Message-ID: <48FE9876.9040003__42678.381157066$1224644977$gmane$org@intel.com>
References: <20081021114056.GA3185@yzhao12-linux.sh.intel.com>
	<20081021115308.GM3185@yzhao12-linux.sh.intel.com>
	<20081021165054.GA24795@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081021165054.GA24795@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Greg KH wrote:
> On Tue, Oct 21, 2008 at 07:53:08PM +0800, Yu Zhao wrote:
>> Support Single Root I/O Virtualization (SR-IOV) capability.
>>
>> Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
>> Cc: Randy Dunlap <randy.dunlap@oracle.com>
>> Cc: Grant Grundler <grundler@parisc-linux.org>
>> Cc: Alex Chiang <achiang@hp.com>
>> Cc: Matthew Wilcox <matthew@wil.cx>
>> Cc: Roland Dreier <rdreier@cisco.com>
>> Cc: Greg KH <greg@kroah.com>
>> Signed-off-by: Yu Zhao <yu.zhao@intel.com>
>>

>> +#define iov_config_attr(field)                                               \
>> +static ssize_t field##_show(struct device *dev,                              \
>> +             struct device_attribute *attr, char *buf)               \
>> +{                                                                    \
>> +     struct pci_dev *pdev = to_pci_dev(dev);                         \
>> +     return sprintf(buf, "%d\n", pdev->iov->field);                  \
>> +}
>> +
>> +iov_config_attr(status);
>> +iov_config_attr(totalvfs);
>> +iov_config_attr(initialvfs);
>> +iov_config_attr(numvfs);
> 
> As you are adding new sysfs entries, can you also create the proper
> documentation in Documentation/ABI/ so that people can understand how to
> use them?  Yes, I see you added a stand-alone document, but putting it
> in the "standard" format is also necessary.

Thanks for reminding me about this. I used to update ABI doc in earlier 
versions, but somehow forgot to do this after several carry-forwards...

Will complete it in next version.

Regards,
Yu
