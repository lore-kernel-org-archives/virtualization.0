From: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH 1/6] Staging: hv: Unify hyper-v device abstractions
Date: Wed, 2 Mar 2011 09:35:02 +0300
Message-ID: <20110302063502.GD18043@bicker>
References: <1298685930-30806-1-git-send-email-kys@microsoft.com>
 <20110301023449.GC1663@kroah.com>
 <6E21E5352C11B742B20C142EB499E0480165E6@TK5EX14MBXC128.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0480165E6@TK5EX14MBXC128.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Greg KH <greg@kroah.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org

The problem is that everyone reading [patch 1/6] thinks you're renaming
hv_device to vm_device or introducing a new struct vm_device.  That
makes people annoyed.  If you had written the patch description like this:

    In the original code, the structs vm_device included a struct
    hv_device.  This patch moves the members from hv_device directly
    into struct vm_device.

    The members ->dev_type and ->dev_instance from hv_device were
    the same as ->class_id and ->device_id in vm_device so those
    were not copied over.

    Now that everything is included into vm_device directly, 
    hv_device is unused and we can delete the definition.

There still might be issues with the patch, but at least you would be
talking about the same thing.

regards,
dan carpenter
